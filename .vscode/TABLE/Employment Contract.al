tableextension 50039 EmploymentContract extends "Employment Contract"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Hours in Day"; Decimal)
        {
            Caption = 'Hours in Day';
        }
        field(50001; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            OptionCaption = 'Worker,Board,Supervisor,Trainee';
            OptionMembers = Worker,Board,Supervisor,Trainee;
        }
        field(50002; "Termination Date Mandatory"; Boolean)
        {
            Caption = 'Termination Date Mandatory';
        }
    }

    var
        myInt: Integer;
}