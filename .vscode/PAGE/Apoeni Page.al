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
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                }



            }
        }


    }

    actions
    {

        area(navigation)
        {
            action("Zapisnik o primopredaji UniCredit")
            {
                Caption = 'Zapisnik o primopredaji UniCredit';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Zapisnik o primopredaji";
            }
        }
    }
}

