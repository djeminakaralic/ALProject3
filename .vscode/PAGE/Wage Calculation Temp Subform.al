page 50044 "Wage Calculation Temp Subform"
{
    // //SPNPL01.00 JB 08.06.2004.
    // 
    // //Purpose:
    // //Wage Calculation Temp subform for Wage Wizard step 5
    // 
    // //Functionality:
    // //View Wage Calculation Temp before closing the calculation

    Caption = 'Wage Calculation Temp Subform';
    PageType = List;
    SourceTable = "Wage Calculation Temp";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                }
                field(Name; Name)
                {
                    Caption = 'Name';
                    Editable = false;
                }
                field(LName; LName)
                {
                    Caption = 'Last Name';
                    Editable = false;
                }
                field("Employee Coefficient"; "Employee Coefficient")
                {
                }
                field(Brutto; Brutto)
                {
                }
                field("Hour Pool"; "Hour Pool")
                {
                }
                field("Net Wage"; "Net Wage")
                {
                }
                field("Tax Deductions"; "Tax Deductions")
                {
                }
                field(Tax; Tax)
                {
                }
                field("Indirect Wage Addition Amount"; "Indirect Wage Addition Amount")
                {
                }
                field("Net Wage After Tax"; "Net Wage After Tax")
                {
                }
                field("Untaxable Wage"; "Untaxable Wage")
                {
                }
                field("Final Net Wage"; "Final Net Wage")
                {
                }
                field("Wage Reduction"; "Wage Reduction")
                {
                }
                field(Payment; Payment)
                {
                }
                field(Transport; Transport)
                {
                }
                field("Meal to pay"; "Meal to pay")
                {
                }
                field("Sick Leave-Company"; "Sick Leave-Company")
                {
                }
                field("Sick Leave-Fund"; "Sick Leave-Fund")
                {
                }
                field("Entity Code"; "Entity Code")
                {
                }
                field("Work Experience Percentage"; "Work Experience Percentage")
                {
                }
                field("Sick Fund Total"; "Sick Fund Total")
                {
                }
                field("Wage Type"; "Wage Type")
                {
                }
                field("Contribution Over Brutto"; "Contribution Over Brutto")
                {
                }
                field("Contribution From Brutto"; "Contribution From Brutto")
                {
                }
                field("Wage Addition"; "Wage Addition")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF Employee.GET("Employee No.") THEN BEGIN
            Name := Employee."First Name";
            LName := Employee."Last Name";
        END;
    end;

    trigger OnOpenPage()
    begin

        //INT1.0 start
        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end
    end;

    var
        EmployeeName: Text[250];
        Employee: Record "Employee";
        WC: Record "Wage Calculation Temp";
        Name: Text[150];
        LName: Text[150];
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

