// Grayscale, lightness


precision mediump float;

uniform sampler2D source;
uniform sampler2D mask;
varying highp vec2 qt_TexCoord0;
uniform lowp float qt_Opacity;

void main(void)
{
    if (texture2D(mask, qt_TexCoord0.st).a > 0.5)
    {
        highp vec4 color = texture2D(source, qt_TexCoord0.st);
        color.rgb = color.rgb/color.a;
        color.rgb = highp vec3((max(max(color.r, color.g), color.b)+min(min(color.r, color.g), color.b))/2.0) * color.a;

        gl_FragColor = color * qt_Opacity;
    }
    else
    {
        gl_FragColor = texture2D(source, qt_TexCoord0.st) * qt_Opacity;
    }
}
