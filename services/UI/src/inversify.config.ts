import "reflect-metadata";
import { Container } from "inversify";
// import { TYPES } from "./constants/types";

// import AnalysisBackendRepository from "@infraestructure/repositories/analysis/AnalysisBackendRepository";
// import IAnalysisRepository from "@application/repositories/IAnalysisRepository";
// import AnalysisService from "@configuration/usecases/AnalysisService";

const container = new Container();

// container.bind<IAnalysisRepository>(TYPES.IAnalysisRepository).to(AnalysisBackendRepository);
// container.bind<AnalysisService>(TYPES.AnalysisService).to(AnalysisService);
// container.resolve(AnalysisService);

export { container }
