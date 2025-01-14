// Swap color channels RGB --> BRG

precision mediump float;

uniform sampler2D source;
uniform sampler2D mask;
varying highp vec2 qt_TexCoord0;
uniform lowp float qt_Opacity;

void main(void)
{
    if (texture2D(mask, qt_TexCoord0.st).a > 0.5)
        gl_FragColor = texture2D(source, qt_TexCoord0.st).brga * qt_Opacity;
    else
        gl_FragColor = texture2D(source, qt_TexCoord0.st) * qt_Opacity;
}
