page 50030 "Wage Value Entries"
{
    PageType = List;
    SourceTable = "Wage Value Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Wage Header Entry No."; "Wage Header Entry No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Wage Posting Group"; "Wage Posting Group")
                {
                }
                field("Wage Ledger Entry No."; "Wage Ledger Entry No.")
                {
                }
                field("Cost Posted to G/L"; "Cost Posted to G/L")
                {
                }
                field("User ID"; "User ID")
                {
                }
                field("Applies-to Entry"; "Applies-to Entry")
                {
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                }
                field("Cost Amount (Actual)"; "Cost Amount (Actual)")
                {
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Entry Type"; "Entry Type")
                {
                }
                field("Contribution Type"; "Contribution Type")
                {
                }
                field(Status; Status)
                {
                }
                field("G/L Entry No. (Account)"; "G/L Entry No. (Account)")
                {
                }
                field("G/L Entry No. (Bal. Account)"; "G/L Entry No. (Bal. Account)")
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

