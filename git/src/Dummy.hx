
import dle.*;
import dle.components.*;


enum abstract States(Int) to Int
{
    var S0;
    var S1;
}

enum abstract Transitions(Int) to Int
{
    var T0;
    var T1;
}

enum InputFunctions
{
    Pickup;
    Jump;
}


class Dummy
{
    public static function main()
    {
        var lst: ScriptComponentList = new ScriptComponentList();

        var x: RangeTrigger = lst[RangeTrigger];

        var s: CameraMover;

        var sm: StateMachine<States, Transitions> = new StateMachine(S0);

        var inp = new MultiFunctionHeldInput<InputFunctions>(Defold.hash("asdf"), () -> Pickup);
    }
}
