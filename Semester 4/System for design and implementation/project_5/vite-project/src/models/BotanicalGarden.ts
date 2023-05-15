import Plant from "./Plant";
import Watching from "./Watching";

export default interface BotanicalGarden{
    id: number;
    bgName: string;
    bgCapacity: number;
    bgPlants: number;
    bgYear: Date;
    bgLocation: string;
    plants: Plant[];
    workers: Worker[];
    watchings: Watching[];
}