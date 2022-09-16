import INewsCreateResDto
    from "@usecases/jobad/create/INewCreateResDto";

export default interface INewsFindResDto {
    totalItems: number; // size (items per page)
    totalPages: number; // total pages found in server db
    currentPage: number; // current get page
    news: INewsCreateResDto[]; //list of users found in this page
}