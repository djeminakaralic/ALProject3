page 50070 "Employee Trainings Ledger"
{


    Caption = 'Employee Training Ledger';
    PageType = List;
    SourceTable = "Employee Training Ledger";


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Employee No."; "Employee No.")
                {

                }
                field("Employee Name"; "Employee Name") { }
                field("Employee Last Name"; "Employee Last Name")
                {

                }
                field(Code; Code)
                {

                }
                field(Code2; Code2)
                {

                }
                field(Type; Type)
                {

                }
                field(Location; Location) { }
                field(Month; Month) { }
                field(Attended; Attended) { }
                field(Mandatory; Mandatory) { }
                field(Status; Status) { }
                field(Grade; Grade) { }

                field("Start date of certificate"; "Start date of certificate") { }
                field("End date of certificate"; "End date of certificate") { }



            }
        }


    }
}


