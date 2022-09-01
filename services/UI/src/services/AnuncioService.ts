import BaseService from "./BaseService";

export default class AnuncioService extends BaseService {
    private static API_RESOURCE = "jobAds";

    constructor() {
        super(AnuncioService.API_RESOURCE);
    }
}
