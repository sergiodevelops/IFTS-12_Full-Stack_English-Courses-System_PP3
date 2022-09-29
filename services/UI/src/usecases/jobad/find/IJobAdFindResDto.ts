import IJobAdCreateResDto
    from "@usecases/jobad/create/IJobAdCreateResDto";

export default interface IJobAdFindResDto {
    totalItems: number; // size (items per page)
    totalPages: number; // total pages found in server db
    currentPage: number; // current get page
    jobads: IJobAdCreateResDto[]; //list of users found in this page
}