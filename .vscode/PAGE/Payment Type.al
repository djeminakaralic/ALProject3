page 50229 "Payment Type"
{
    ApplicationArea = all;
    Caption = 'Vrsta uplate';
    PageType = List;
    SourceTable = "Payment Type";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    //ToolTip = 'Specifies a code for the employment contract.';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    //ToolTip = 'Specifies a description for the employment contract.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
    }
}
