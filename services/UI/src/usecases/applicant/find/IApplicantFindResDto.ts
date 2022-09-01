import IApplicantCreateResDto
    from "@usecases/applicant/create/IApplicantCreateResDto";

export default interface IApplicantFindResDto {
    totalItems: number; // size (items per page)
    totalPages: number; // total pages found in server db
    currentPage: number; // current get page
    applicants: IApplicantCreateResDto[]; //list of applicants found in this page
}
