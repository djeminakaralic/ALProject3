tableextension 50148 GroundForTermination extends "Grounds for Termination"
{
    fields
    {
        field(50000; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Reason,Manner';
            OptionMembers = Reason,Manner;
        }
    }

    var
        myInt: Integer;
}