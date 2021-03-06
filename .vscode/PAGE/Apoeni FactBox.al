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

                trigger OnDrillDown()
                var
                    Today: Date;
                begin
                    Today := System.Today;
                    ApoeniTable.Reset();
                    ApoeniTable.SetFilter("Posting Date", '%1', Today);
                    ApoeniTable.SetFilter("Bal. Account No.", '%1', Rec."Bal. Account No.");
                    ApoeniPage.SetTableView(ApoeniTable);
                    ApoeniPage.Run();
                end;

            }
        }
    }

    var
        GJLine: Record "Gen. Journal Line";
        ApoeniTable: Record Apoeni;
        ApoeniPage: Page "Apoeni Page";
        GenJnlManagement: Codeunit GenJnlManagement;
}