page 50238 "Wage/Reduction Banks"
{
    Caption = 'Reduction Banks';
    PageType = List;
    SourceTable = "Wage/Reduction Bank";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Name; Name)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end
    end;

    var
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

