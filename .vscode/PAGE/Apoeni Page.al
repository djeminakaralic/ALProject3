page 51067 "Apoeni Page"
{
    //ED
    Caption = 'Apoeni';
    PageType = List;
    SourceTable = Apoeni;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    //Visible = false;
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
                field(Amount;Amount)
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

