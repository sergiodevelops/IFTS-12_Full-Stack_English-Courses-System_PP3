// import IUserLoginResDto from "@usecases/user/login/IUserLoginResDto";

export default interface IPersonFindResDto {
    IdPersona: number; 
    documento: number; 
    nombre: number; 
    apellido: string;
    fecha_nac: string;
    email: string;
}