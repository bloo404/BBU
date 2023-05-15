import BotanicalGarden from "./BotanicalGarden";
import Watching from "./Watching";

export default interface Worker{
    id: number;
    workerParent: BotanicalGarden;
    workerFirstName: string;
    workerLastName: string;
    workerBirthDate: Date;
    workerStartDate: Date;
    workerJob: string;
}