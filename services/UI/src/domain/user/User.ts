export default class User {
    // public IdUsuario: number;
    public tipo_usuario: number;
    public es_admin: number;
    // public nombre_completo: string;
    public username: string;
    public password: string;
    public fecha_alta: string;

    constructor(
        // IdUsuario: number,
        tipo_usuario: number,
        es_admin: number,
        // nombre_completo: string,
        username: string,
        password: string,
        fecha_alta: string,
    ) {
        // this.IdUsuario = IdUsuario;
        this.tipo_usuario = tipo_usuario;
        this.es_admin = es_admin;
        // this.nombre_completo = nombre_completo;
        this.username = username;
        this.password = password;
        this.fecha_alta = fecha_alta;
    }
}
