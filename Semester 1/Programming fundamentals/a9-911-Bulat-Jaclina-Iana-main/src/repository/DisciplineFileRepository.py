from src.domain.Discipline import Discipline
from src.repository.DisciplineRepository import *
import pickle

class DisciplineTextFileRepository(DisciplineRepository):
    def __init__(self,filename):
        super().__init__()

        self._file_name = filename
        self._load_file()

    def _load_file(self):
        with open(self._file_name,"rt") as f:
            for line in f.readlines():
                if line != "\n":
                    ID,name = line.split(maxsplit=1,sep = ",")
                    self.addDiscipline(int(ID),str(name))

    def _save_file(self):
        with open(self._file_name,"wt") as f:
            for discipline in self.get_discRepo():
                writtenDisc = str(discipline)
                writtenDisc += '\n'
                f.write(writtenDisc)

    def __len__(self):
        DisciplineRepository.__len__(self)

    def addDiscipline(self, id, name):
        super(DisciplineTextFileRepository,self).add(int(id),name)
        self._save_file()

