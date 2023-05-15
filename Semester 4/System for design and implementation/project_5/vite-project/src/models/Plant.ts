import BotanicalGarden from "./BotanicalGarden";
import Watching from "./Watching";

export default interface Plant{
    id: number;
    plantParent: BotanicalGarden;
    plantCommonName: string;
    plantLatinName: string;
    plantLength: number;
    plantTemperatureLevel: number;
    plantSoilType: string;
    plantHydrationLevel: number;
    plantAge: number;
    watchings: Watching[];
}