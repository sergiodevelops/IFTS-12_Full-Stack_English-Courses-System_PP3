// import IUserLoginResDto from "@usecases/user/login/IUserLoginResDto";

export default interface IUserFindAdminResDto {
    exist: boolean;
    // totalItems: number; // size (items per page)
    // totalPages: number; // total pages found in server db
    // currentPage: number; // current get page
    // users: IUserLoginResDto[]; //list of users found in this page
}