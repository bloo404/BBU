package Model.Expression;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIHeap;
import Model.Type.BoolType;
import Model.Type.IntType;
import Model.Type.Type;
import Model.Value.BoolValue;
import Model.Value.IntValue;
import Model.Value.Value;

public class RelExp implements Exp{

    Exp e1,e2;
    int op;

    public RelExp(String c, Exp e1, Exp e2){
        if(c.equals("<")){
            this.op = 1;
        } else if(c.equals("<=")){
            this.op = 2;
        } else if(c.equals("==")){
            this.op = 3;
        } else if(c.equals("!=")){
            this.op = 4;
        } else if(c.equals(">")){
            this.op = 5;
        } else if(c.equals(">=")){
            this.op = 6;
        }
        this.e1 = e1;
        this.e2 = e2;
    }
    @Override
    public Value eval(MyIDictionary<String, Value> tbl, MyIHeap heap) throws MyException {
        Value v1, v2;
        v1 = e1.eval(tbl,heap);

        if(v1.getType().equals(new IntType())){
            v2 = e2.eval(tbl,heap);
            if(v2.getType().equals(new IntType())){

                IntValue i1 = (IntValue) v1;
                IntValue i2 = (IntValue) v2;

                int n1, n2;

                n1 = i1.getVal();
                n2 = i2.getVal();

                if(op == 1) return new BoolValue(n1 < n2);
                if(op == 2) return new BoolValue(n1 <= n2);
                if(op == 3) return new BoolValue(n1 == n2);
                if(op == 4) return new BoolValue(n1 != n2);
                if(op == 5) return new BoolValue(n1 > n2);
                if(op == 6) return new BoolValue(n1 >= n2);

            } else {
                throw new MyException("second operand not an integer");
            }
        } else {
            throw new MyException("first operand not an integer");
        }
        return new BoolValue(false);
    }

    @Override
    public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typ1, typ2;
        typ1 = e1.typecheck(typeEnv);
        typ2 = e2.typecheck(typeEnv);
        if (typ1.equals(new IntType())) {
            if (typ2.equals(new IntType())) {
                return new BoolType();
            } else
                throw new MyException("second operand is not an integer");
        } else throw new MyException("first operand is not an integer");
    }

    @Override
    public Exp deepCopy() {
        return new RelExp(convertOperation(op),e1.deepCopy(),e2.deepCopy());
    }

    String convertOperation(int op){
        if(op == 1) return "<";
        if(op == 2) return "<=";
        if(op == 3) return "==";
        if(op == 4) return "!=";
        if(op == 5) return ">";
        if(op == 6) return ">=";

        return "";
    }

    @Override
    public String toString() {
        return "RelExp{" +
                "e1=" + e1 +
                ", e2=" + e2 +
                ", op=" + op +
                '}';
    }

    public Exp getE1() {
        return e1;
    }

    public void setE1(Exp e1) {
        this.e1 = e1;
    }

    public Exp getE2() {
        return e2;
    }

    public void setE2(Exp e2) {
        this.e2 = e2;
    }

    public int getOp() {
        return op;
    }

    public void setOp(int op) {
        this.op = op;
    }
}
