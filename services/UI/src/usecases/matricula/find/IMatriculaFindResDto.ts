import IMatriculaCreateResDto from "@usecases/matricula/create/IMatriculaCreateResDto";

export default interface IMatriculaFindResDto {
    totalItems: number; // size (items per page)
    totalPages: number; // total pages found in server db
    currentPage: number; // current get page
    matriculas: IMatriculaCreateResDto[]; //list of applicants found in this page
}
