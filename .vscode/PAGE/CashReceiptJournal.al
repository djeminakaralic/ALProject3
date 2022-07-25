pageextension 50170 CashReceiptJournal extends "Cash Receipt Journal"
{
    //ED

    layout
    {
        addafter(JournalLineDetails)
        {
            part(ApoeniFactBox; "Apoeni FactBox")
            {
                ApplicationArea = Basic, Suite;

                SubPageLink = "Journal Template Name" = FIELD("Journal Template Name"),
                              "Journal Batch Name" = FIELD("Journal Batch Name"),
                              "Bal. Account No." = field("Bal. Account No."),
                              "Line No." = FIELD("Line No.");
            }
        }

        modify(IncomingDocAttachFactBox)
        {
            Visible = false;
        }

        /*addafter(CurrentJnlBatchName)
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
        /*Page.Run(Page::"Bank Account Card", BankAccounts);
    end
    else
        if "Journal Batch Name" = 'CZK2 UPL' then begin
            BankAccounts.SetFilter("No.", '%1', 'BANK-11');
            Page.Run(Page::"Bank Account Card", BankAccounts);
        end
        else
            if "Journal Batch Name" = 'CZK3 UPL' then begin
                BankAccounts.SetFilter("No.", '%1', 'BANK-12');
                Page.Run(Page::"Bank Account Card", BankAccounts);
            end
            else
                if "Journal Batch Name" = 'CZK4 UPL' then begin
                    BankAccounts.SetFilter("No.", '%1', 'BANK-13');
                    Page.Run(Page::"Bank Account Card", BankAccounts);
                end
                else
                    if "Journal Batch Name" = 'CZK5 UPL' then begin
                        BankAccounts.SetFilter("No.", '%1', 'BANK-14');
                        Page.Run(Page::"Bank Account Card", BankAccounts);
                    end
                    else
                        if "Journal Batch Name" = 'CZK6 UPL' then begin
                            BankAccounts.SetFilter("No.", '%1', 'BANK-15');
                            Page.Run(Page::"Bank Account Card", BankAccounts);
                        end
                        else
                            if "Journal Batch Name" = 'CZK7 UPL' then begin
                                BankAccounts.SetFilter("No.", '%1', 'BANK-16');
                                Page.Run(Page::"Bank Account Card", BankAccounts);
                            end
                            else
                                if "Journal Batch Name" = 'CZK8 UPL' then begin
                                    BankAccounts.SetFilter("No.", '%1', 'BANK-17');
                                    Page.Run(Page::"Bank Account Card", BankAccounts);
                                end
                                else
                                    if "Journal Batch Name" = 'CZK9 UPL' then begin
                                        BankAccounts.SetFilter("No.", '%1', 'BANK-18');
                                        Page.Run(Page::"Bank Account Card", BankAccounts);
                                    end;

end;
}
}*/

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
            field("Main Cashier"; "Main Cashier")
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
        modify(Correction)
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

            action("Transfer")
            {
                Caption = 'Transfer';
                Image = TransferFunds;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Rec.FINDFIRST;
                    BEGIN
                        IF Rec."Main Cashier" = FALSE THEN BEGIN //postavljam true da svaki red ide na pregled kod glavnog blagajnika
                            REPEAT
                                Validate(Rec."Main Cashier", TRUE);
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END

                    END;

                    GJline.Reset(); //insertujem novi red kada se vrsi prenos plata u "racunski centar"

                    GJline.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
                    GJline.SetFilter("Journal Batch Name", '%1', "Journal Batch Name");
                    GJline.SetFilter("Bal. Account No.", '%1', Rec."Bal. Account No.");
                    TotalAmount := 0;

                    if GJline.FindFirst() then
                        repeat
                            TotalAmount += abs(GJline.Amount);
                        until GJline.Next() = 0;

                    if GJline.FindLast() then
                        LineNo := GJline."Line No." + 10000
                    else
                        LineNo := 10000;

                    GJline.Init();
                    GJline."Line No." := LineNo;
                    GJline."Journal Template Name" := Rec."Journal Template Name";
                    GJline."Journal Batch Name" := Rec."Journal Batch Name";
                    GJline."Posting Date" := System.Today;
                    GJline.Amount := TotalAmount;
                    GJline."Payment DT" := System.CurrentDateTime;
                    GJline."Main Cashier" := true;
                    GJline."Debit Amount" := TotalAmount;
                    GJline.Description := 'Polog pazara';

                    //testirati
                    GJline."Bal. Account Type" := "Bal. Account Type"::"Bank Account";
                    GJline."Bal. Account No." := Rec."Bal. Account No.";
                    GJline."Account Type" := "Account Type"::"G/L Account";
                    GJline."Account No." := '20009';

                    /*GJline."Bal. Account No." := '2388';
                    GJline."Account Type" := "Account Type"::"G/L Account";
                    GJline."Account No." := '2050';*/
                    GJline.Insert();

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

        /*BankAccount.Get(Rec."Bal. Account No.");
        "Cash Register":=BankAccount.Name;*/

        "Payment DT" := System.CurrentDateTime;
        Description := '';
    end;

    var
        TotalAmount: Decimal;
        LineNo: Integer;
        BankAccount: Record "Bank Account";
        GJline: Record "Gen. Journal Line";
        CLEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        Text000: Label 'Today is %1';
}