page 50148 "Apoeni FactBox"
{
    PageType = CardPart;
    Caption = 'Apoeni FactBox';
    Editable = false;
    LinksAllowed = false;
    UsageCategory = Administration;
    SourceTable = Apoeni;

    layout
    {
        area(Content)
        {
            field(PostingGroup; Apoeni)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posting Group';
                Editable = false;

                ToolTip = 'Specifies the account posting group that the entry on the journal line will be posted to.';

                trigger OnDrillDown()
                begin

                end;
            }


        }
    }

    trigger OnAfterGetCurrRecord()
    begin

    end;

    var
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