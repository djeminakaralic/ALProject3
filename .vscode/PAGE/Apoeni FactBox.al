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
            field(Apoeni;Apoeni)
            {
                ApplicationArea = All;
                Caption = 'Apoeni Total';
                

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

    end;

    var
        GJLine: Record "Gen. Journal Line";
        GenJnlManagement: Codeunit GenJnlManagement;
        AccName: Text[100];
        BalAccName: Text[100];
        GenPostingSetupText: Text;
        VATPostingSetupText: Text;
        BalGenPostingSetupText: Text;
        BalVATPostingSetupText: Text;
        AccountEnabled: Boolean;
        BalAccountEnabled: Boolean;
        GenPostingSetupEnabled: Boolean;
        VATPostingSetupEnabled: Boolean;
        BalGenPostingSetupEnabled: Boolean;
        BalVATPostingSetupEnabled: Boolean;


}