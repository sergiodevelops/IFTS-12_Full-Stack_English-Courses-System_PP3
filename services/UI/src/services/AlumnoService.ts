import BaseService from "./BaseService";

export default class AlumnoService extends BaseService {
    private static API_RESOURCE = "applicants";

    constructor() {
        super(AlumnoService.API_RESOURCE);
    }
}
