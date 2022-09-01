export default class Pagination {
    public size: number;
    public page: number;

    constructor(
        size: number,
        page: number
    ) {
        this.size = size;
        this.page = page;
    }
}
