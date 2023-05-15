import { useEffect, useState } from "react";
import BotanicalGarden from "../../models/BotanicalGarden";

export const BotanicalGardenShowAll = () => {
  const [botanicalGarden, setBotanicalGarden] = useState([]);

  useEffect(() => {
  fetch("http://ec2-13-53-243-233.eu-north-1.compute.amazonaws.com/api/botanicalgarden/")
  .then(res => res.json())
  .then(data => {
    console.log(data);
    setBotanicalGarden(data)});
  },[]);

  return (
    <div className="App">
      <h1>Botanical Garden List</h1>
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Name</th>
            <th>People capacity</th>
            <th>Plant capacity</th>
            <th>Location</th>
          </tr>
        </thead>
        <tbody>
        {botanicalGarden.map((botanicalGarden: BotanicalGarden, index) => {
            return (
              <tr key={index}>
                <td>{index}</td>
                <td>{botanicalGarden.bgName}</td>
                <td>{botanicalGarden.bgCapacity}</td>
                <td>{botanicalGarden.bgPlants}</td>
                <td>{botanicalGarden.bgLocation}</td>
              </tr>
            )
          })}
        </tbody>
      </table>

    </div>
  )

};
  