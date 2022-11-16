import BaseService from "./BaseService";

export default class AulaService extends BaseService {
    private static API_RESOURCE = "classroom";

    constructor() {
        super(AulaService.API_RESOURCE);
    }
}
