import ICourseCreateResDto from "@usecases/course/create/ICourseCreateResDto";

export default interface ICoursesFindResDto {
    totalItems: number; // size (items per page)
    totalPages: number; // total pages found in server db
    currentPage: number; // current get page
    courses: ICourseCreateResDto[]; //list of applicants found in this page
}
