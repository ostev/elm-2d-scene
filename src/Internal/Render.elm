module Internal.Render exposing (makeViewProjection, shapeToEntity)

import Internal.Shape
import Internal.Texture
import Internal.Vertex as Vertex exposing (Vertex)
import Math.Matrix4 as Mat4 exposing (Mat4)
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Math.Vector3 exposing (vec3)
import Scene.Angle as Angle
import Scene.Camera as Camera exposing (Camera)
import Scene.Dimensions as Dimensions exposing (Dimensions)
import Scene.Point as Point exposing (Point)
import Scene.Shape as Shape exposing (Shape)
import Scene.Texture as Texture
import WebGL
import WebGL.Texture


tupleMapThree : (a -> b) -> ( a, a, a ) -> ( b, b, b )
tupleMapThree f ( x, y, z ) =
    ( f x, f y, f z )


makeProjection : Dimensions -> Mat4
makeProjection dimensions =
    Mat4.makeOrtho
        0
        (Dimensions.width dimensions)
        (Dimensions.height dimensions)
        0
        -1
        -1


makeViewProjection : Camera -> Mat4
makeViewProjection camera =
    let
        dimensions =
            Camera.dimensions camera
    in
    Mat4.inverseOrthonormal (makeCamera camera)
        |> Mat4.mul (makeProjection dimensions)


makeCamera : Camera -> Mat4
makeCamera camera =
    let
        position =
            Camera.position camera
    in
    Mat4.identity
        |> Mat4.translate
            (vec3
                (Point.getX position)
                (Point.getY position)
                0
            )


calculateMatrix : Mat4 -> Internal.Shape.Attributes -> Mat4
calculateMatrix viewProjection attributes =
    viewProjection
        |> Mat4.translate
            (vec3
                (Point.getX attributes.translation)
                (Point.getY attributes.translation)
                0
            )
        |> Mat4.rotate (Angle.toRadians attributes.rotation) (vec3 1 0 0)
        |> Mat4.scale (vec3 attributes.scale.x attributes.scale.y 1)


shapeToEntity : Mat4 -> Shape -> WebGL.Entity
shapeToEntity viewProjection (Internal.Shape.Shape attributes shapeType) =
    let
        matrix =
            calculateMatrix
                viewProjection
                attributes
    in
    case shapeType of
        Internal.Shape.Image texture position ->
            WebGL.entity
                texturedVertexShader
                texturedFragmentShader
                (let
                    size =
                        Texture.dimensions texture

                    x1 =
                        Point.getX position

                    x2 =
                        x1 + Dimensions.width size

                    y1 =
                        Point.getY position

                    y2 =
                        y1 + Dimensions.height size
                 in
                 WebGL.triangles
                    [ ( { a_position = vec2 x1 y1, a_texcoord = vec2 0 1 }
                      , { a_position = vec2 x2 y1, a_texcoord = vec2 1 1 }
                      , { a_position = vec2 x1 y2, a_texcoord = vec2 0 0 }
                      )
                    , ( { a_position = vec2 x1 y2, a_texcoord = vec2 0 0 }
                      , { a_position = vec2 x2 y1, a_texcoord = vec2 1 1 }
                      , { a_position = vec2 x2 y2, a_texcoord = vec2 1 0 }
                      )
                    ]
                )
                { u_matrix = matrix
                , u_texture = Internal.Texture.toWebGLTexture texture
                }

        Internal.Shape.Basic color kind ->
            case kind of
                Internal.Shape.Triangles triangles ->
                    WebGL.entity
                        vertexShader
                        fragmentShader
                        (List.map
                            (tupleMapThree Vertex.fromPoint)
                            triangles
                            |> WebGL.triangles
                        )
                        { u_matrix = matrix }

                Internal.Shape.Circle _ _ ->
                    Debug.todo "Circles not yet implemented"


type alias Uniforms =
    { u_matrix : Mat4 }


type alias TexturedUniforms =
    { u_matrix : Mat4
    , u_texture : WebGL.Texture.Texture
    }


vertexShader : WebGL.Shader Vertex.Untextured Uniforms {}
vertexShader =
    [glsl|
        attribute vec2 a_position;
        uniform mat4 u_matrix;
        void main() {
          // Multiply the position by the matrix.
          gl_Position = vec4((u_matrix * vec4(a_position, 1, 1)).xy, 0, 1);
        } 
    |]


texturedVertexShader : WebGL.Shader Vertex.Textured TexturedUniforms { v_texcoord : Vec2 }
texturedVertexShader =
    [glsl|
        attribute vec2 a_position;
        attribute vec2 a_texcoord;
        
        uniform mat4 u_matrix;
        varying vec2 v_texcoord;
        void main() {
            // Multiply the position by the matrix.
            gl_Position = vec4((u_matrix * vec4(a_position, 1, 1)).xy, 0, 1);
            v_texcoord = a_texcoord;
        }
    |]


fragmentShader : WebGL.Shader {} Uniforms {}
fragmentShader =
    [glsl|
        precision mediump float;
        // uniform vec4 u_color;
        void main() {
            gl_FragColor = vec4(0, 0, 0, 1);
        }
    |]


texturedFragmentShader : WebGL.Shader {} TexturedUniforms { v_texcoord : Vec2 }
texturedFragmentShader =
    [glsl|
        precision mediump float;
 
        varying vec2 v_texcoord;
        
 
        uniform sampler2D u_texture;
         
        void main() {
           gl_FragColor = texture2D(u_texture, v_texcoord);
        }
    |]
