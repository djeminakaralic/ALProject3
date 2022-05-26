page 50267 "Wage Addition Types"
{
    Caption = 'Wage Addition Types';
    PageType = List;
    SourceTable = "Wage Addition Type";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Calculation Type"; "Calculation Type")
                {
                }
                field(Use; Use)
                {
                }
                field(Regres; Regres)
                {
                }
                field(Incentive; Incentive)
                {

                }
                field("Default Amount"; "Default Amount")
                {
                }
                field("Calculated on Neto (Calc.)"; "Calculated on Neto (Calc.)")
                {
                }
                field("Calculated on Neto (Base)"; "Calculated on Neto (Base)")
                {
                }
                field("Calculate Experience"; "Calculate Experience")
                {
                }
                field("Calculate Deduction"; "Calculate Deduction")
                {
                }
                field(Taxable; Taxable)
                {
                }
                field("Add. Taxable"; "Add. Taxable")
                {
                }
                field("G/L Account No."; "G/L Account No.")
                {
                }
                field("G/L Balance Account No."; "G/L Balance Account No.")
                {
                }
                field("Transit Account No."; "Transit Account No.")
                {
                }
                field("Use Apportionment Account"; "Use Apportionment Account")
                {
                }
                field("Apportionment Account"; "Apportionment Account")
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

        //INT1.0 start
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

