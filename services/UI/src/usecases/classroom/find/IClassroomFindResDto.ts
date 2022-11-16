import IClassroomCreateResDto from "@usecases/classroom/create/IClassroomCreateResDto";

export default interface IClassroomFindResDto {
    totalItems: number; // size (items per page)
    totalPages: number; // total pages found in server db
    currentPage: number; // current get page
    classrooms: IClassroomCreateResDto[]; //list of classrooms found in this page
}
