pageextension 50170 CashReceiptJournal extends "Cash Receipt Journal"
{
    //ED

    layout
    {
        addafter(CurrentJnlBatchName)
        {
            field("Cash Register"; "Cash Register")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Blagajna';
                Editable = false;

                trigger OnDrillDown()
                var
                    BankAccounts: Record "Bank Account";
                begin
                    if "Journal Batch Name" = 'CZK1 UPL' then begin
                        BankAccounts.SetFilter("No.", '%1', 'BANK-10');
                        /*if BankAccounts.FindFirst() then
                            "Cash Register" := BankAccounts.Name;*/
                        Page.Run(Page::"Bank Account Card", BankAccounts);
                    end
                    else
                        if "Journal Batch Name" = 'CZK2 UPL' then begin
                            BankAccounts.SetFilter("No.", '%1', 'BANK-11');
                            Page.Run(Page::"Bank Account Card", BankAccounts);
                        end
                        else
                            if "Journal Batch Name" = 'CZK3 UPL' then begin
                                BankAccounts.SetFilter("No.", '%1', 'BANK-12');
                                if BankAccounts.FindFirst() then
                                    "Cash Register" := BankAccounts.Name;
                                Page.Run(Page::"Bank Account Card", BankAccounts);
                            end
                            else
                                if "Journal Batch Name" = 'CZK4 UPL' then begin
                                    BankAccounts.SetFilter("No.", '%1', 'BANK-13');
                                    if BankAccounts.FindFirst() then
                                        "Cash Register" := BankAccounts.Name;
                                    Page.Run(Page::"Bank Account Card", BankAccounts);
                                end
                                else
                                    if "Journal Batch Name" = 'CZK5 UPL' then begin
                                        BankAccounts.SetFilter("No.", '%1', 'BANK-14');
                                        if BankAccounts.FindFirst() then
                                            "Cash Register" := BankAccounts.Name;
                                        Page.Run(Page::"Bank Account Card", BankAccounts);
                                    end
                                    else
                                        if "Journal Batch Name" = 'CZK6 UPL' then begin
                                            BankAccounts.SetFilter("No.", '%1', 'BANK-15');
                                            if BankAccounts.FindFirst() then
                                                "Cash Register" := BankAccounts.Name;
                                            Page.Run(Page::"Bank Account Card", BankAccounts);
                                        end
                                        else
                                            if "Journal Batch Name" = 'CZK7 UPL' then begin
                                                BankAccounts.SetFilter("No.", '%1', 'BANK-16');
                                                if BankAccounts.FindFirst() then
                                                    "Cash Register" := BankAccounts.Name;
                                                Page.Run(Page::"Bank Account Card", BankAccounts);
                                            end
                                            else
                                                if "Journal Batch Name" = 'CZK8 UPL' then begin
                                                    BankAccounts.SetFilter("No.", '%1', 'BANK-17');
                                                    if BankAccounts.FindFirst() then
                                                        "Cash Register" := BankAccounts.Name;
                                                    Page.Run(Page::"Bank Account Card", BankAccounts);
                                                end
                                                else
                                                    if "Journal Batch Name" = 'CZK9 UPL' then begin
                                                        BankAccounts.SetFilter("No.", '%1', 'BANK-18');
                                                        if BankAccounts.FindFirst() then
                                                            "Cash Register" := BankAccounts.Name;
                                                        Page.Run(Page::"Bank Account Card", BankAccounts);
                                                    end;
                    
                end;
            }
        }

        addafter("Posting Date")
        {
            field("Payment DT"; "Payment DT")
            {
                ApplicationArea = all;
            }
            field("Payment Type"; "Payment Type")
            {
                ApplicationArea = all;
            }
            field("Payment Method"; "Payment Method")
            {
                ApplicationArea = all;
            }
        }

        movebefore(Amount; "Applies-to Doc. No.")
        moveafter("Bal. VAT Amount"; "Applies-to Doc. Type")
        moveafter("Bal. VAT Amount"; "Document Type")
        moveafter("Credit Amount"; "Account Type")

        addafter("Amount (LCY)")
        {
            /*field(Apoeni; Apoeni)
            {
                ApplicationArea = all;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.Update();
                    Rec."Given amount" := Rec.Apoeni;
                end;
            }*/
            field("Given amount"; "Given amount")
            {
                ApplicationArea = all;
            }
            field("To return"; "To return")
            {
                ApplicationArea = all;
            }
        }
        modify("Applied (Yes/No)")
        {
            Visible = false;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
    }

    actions
    {
        addafter(Card)
        {
            action("Payment Slip")
            {
                Caption = 'Payment Slip';
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(GJline);
                    Report.RunModal(50077, true, false, GJline);
                end;
            }

            /*action("Payroll")
            {
                Caption = 'Payroll';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Isplatnica";
            }*/
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Validate(Rec."Applies-to Doc. Type", "Applies-to Doc. Type"::Invoice);
        Validate(Rec."Document Type", "Document Type"::Payment);
        Validate(Rec."Account Type", "Account Type"::Customer);
        Validate(Rec."Bal. Account Type", "Bal. Account Type"::"Bank Account");
        if "Journal Batch Name" = 'CZK1 UPL' then
            Validate(rec."Bal. Account No.", 'BANK-10')
        else
            if "Journal Batch Name" = 'CZK2 UPL' then
                Validate(rec."Bal. Account No.", 'BANK-11')
            else
                if "Journal Batch Name" = 'CZK3 UPL' then
                    Validate(rec."Bal. Account No.", 'BANK-12')
                else
                    if "Journal Batch Name" = 'CZK4 UPL' then
                        Validate(rec."Bal. Account No.", 'BANK-13')
                    else
                        if "Journal Batch Name" = 'CZK5 UPL' then
                            Validate(rec."Bal. Account No.", 'BANK-14')
                        else
                            if "Journal Batch Name" = 'CZK6 UPL' then
                                Validate(rec."Bal. Account No.", 'BANK-15')
                            else
                                if "Journal Batch Name" = 'CZK7 UPL' then
                                    Validate(rec."Bal. Account No.", 'BANK-16')
                                else
                                    if "Journal Batch Name" = 'CZK8 UPL' then
                                        Validate(rec."Bal. Account No.", 'BANK-17')
                                    else
                                        if "Journal Batch Name" = 'CZK9 UPL' then Validate(rec."Bal. Account No.", 'BANK-18');

        "Payment DT" := System.CurrentDateTime;
        Description := '';
    end;

    var
        GJline: Record "Gen. Journal Line";
        CLEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        Text000: Label 'Today is %1';
}