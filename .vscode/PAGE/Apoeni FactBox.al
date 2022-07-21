page 50148 "Apoeni FactBox"
{
    PageType = CardPart;
    Caption = 'Apoeni FactBox';
    Editable = false;
    LinksAllowed = false;
    UsageCategory = Administration;
    SourceTable = "Gen. Journal Line";

    layout
    {
        area(Content)
        {
            field(Apoeni; Apoeni)
            {
                ApplicationArea = All;
                Caption = 'Apoeni Total';

                trigger OnDrillDown()
                var
                    Today: Date;
                begin
                    Today := System.Today;
                    ApoeniTable.Reset();
                    //ApoeniTable.SetFilter("Posting Date", Today);
                    ApoeniTable.SetFilter("Bal. Account No.", 'BANK-04');
                    ApoeniPage.Run();
                end;

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

    end;

    var
        GJLine: Record "Gen. Journal Line";
        ApoeniTable: Record Apoeni;

        ApoeniPage: Page "Apoeni Page";
        GenJnlManagement: Codeunit GenJnlManagement;



}