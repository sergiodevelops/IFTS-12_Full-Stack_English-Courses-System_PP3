import BaseService from "./BaseService";

export default class CursoService extends BaseService {
    private static API_RESOURCE = "courses";

    constructor() {
        super(CursoService.API_RESOURCE);
    }
}
