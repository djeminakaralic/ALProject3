page 50173 "Employee Bood Donations"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Blood Donation";

    layout
    {
        area(Content)
        {

            field("Employee No."; "Employee No.")
            {
                ApplicationArea = all;
            }
            field("Employee Name"; "Employee Name")
            {
                ApplicationArea = All;

            }
            field(Date; Date)
            {
                ApplicationArea = all;
            }
            field("Team Name"; "Team Name")
            {
                ApplicationArea = all;
            }
            field("Group Name"; "Group Name")
            {
                ApplicationArea = all;
            }
            field("Department Name"; "Department Name")
            {
                ApplicationArea = all;
            }
            field("Sector Name"; "Sector Name")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}