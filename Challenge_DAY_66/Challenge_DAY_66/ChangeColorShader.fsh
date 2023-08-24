

void main() {
    // A cor que você deseja aplicar ao sprite (no formato RGBA)
    vec4 desiredColor = vec4(0.0, 1.0, 0.0, 1.0);  // Cor verde

    // A cor original da textura
    vec4 textureColor = texture2D(u_texture, v_tex_coord);
    
    // Multiplicando as cores original e desejada para obter a cor final
    gl_FragColor = desiredColor * textureColor;
}
