import BaseService from "./BaseService";

export default class MatriculaService extends BaseService {
    private static API_RESOURCE = "matriculas";

    constructor() {
        super(MatriculaService.API_RESOURCE);
    }
}
