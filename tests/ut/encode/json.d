module ut.encode.json;


import ut;
import cerealed;
import cerealed.backend.json;


@("bool")
@safe pure unittest {
    false.cerealise!Json.should == `false`;
    true.cerealise!Json.should == `true`;
}
