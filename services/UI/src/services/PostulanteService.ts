import BaseService from "./BaseService";

export default class PostulanteService extends BaseService {
    private static API_RESOURCE = "applicants";

    constructor() {
        super(PostulanteService.API_RESOURCE);
    }
}
