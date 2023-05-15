import Plant from "./Plant";
import Worker from "./Worker";

export default interface Watching{
    worker: Worker;
    plant: Plant;
    watchingTime: Date;
    watchingReward: number;
}