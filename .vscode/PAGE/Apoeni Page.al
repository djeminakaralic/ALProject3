page 51067 "Apoeni Page"
{
    //ED
    Caption = 'Apoeni';
    PageType = List;
    SourceTable = Apoeni;
    UsageCategory = Lists;
    ApplicationArea = all;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Apoeni; Apoeni)
                {
                    ApplicationArea = all;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = all;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                }
                field("G/L Entry No."; "G/L Entry No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

}

