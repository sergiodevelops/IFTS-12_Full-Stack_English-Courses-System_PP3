import BaseService from "./BaseService";

export default class AvisoService extends BaseService {
    private static API_RESOURCE = "news";

    constructor() {
        super(AvisoService.API_RESOURCE);
    }
}
