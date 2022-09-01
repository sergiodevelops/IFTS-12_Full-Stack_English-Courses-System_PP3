export default class User {
    public id: number;
    public tipo_usuario: number;
    public nombre_completo: string;
    public username: string;
    public password: string;
    public fecha_alta: string;

    constructor(
        id: number,
        tipo_usuario: number,
        nombre_completo: string,
        username: string,
        password: string,
        fecha_alta: string,
    ) {
        this.id = id;
        this.tipo_usuario = tipo_usuario;
        this.nombre_completo = nombre_completo;
        this.username = username;
        this.password = password;
        this.fecha_alta = fecha_alta;
    }
}
