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
        moveafter("Document No."; "Account Type")
        movebefore("Applies-to Doc. Type"; "Document Type")

        addafter("Amount (LCY)")
        {
            field("Given amount"; "Given amount")
            {
                ApplicationArea = all;
            }
            field("To return"; "To return")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Bal. Account No."; "Posting Date")
        moveafter("To return"; "Document No.")
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
            action("Non Fiscal Print")
            {
                Caption = 'Non Fiscal Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Fiscal: Codeunit "Non Fiscal print";
                begin
                    Fiscal.SetParam(Rec."Line No.", Rec."Journal Batch Name", Rec."Journal Template Name", Rec."Document No.");
                    Fiscal.Run();

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

                    GJline.Reset(); //insertujem novi red kada se vrsi prenos uplata u "racunski centar"

                    GJline.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
                    GJline.SetFilter("Journal Batch Name", '%1', "Journal Batch Name");
                    GJline.SetFilter("Bal. Account No.", '%1', Rec."Bal. Account No.");
                    TotalAmount := 0;

                    if GJline.FindFirst() then
                        repeat
                            TotalAmount += GJline."Credit Amount";
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

                    BankAccount.get(Rec."Bal. Account No."); //broj računa je tranzitni konto koji je postavljen na kartici bankovnog racuna
                    GJline."Account No." := BankAccount."Transit G/L account";

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

    trigger OnAfterGetRecord()
    begin

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            SetFilter("Main Cashier", '%1', UserSetup."Main Cashier");
    end;

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            //SetFilter("Journal Template Name", '%1', UserSetup.CurrentJnlBatchName);
            SetFilter("Main Cashier", '%1', UserSetup."Main Cashier");
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Validate(Rec."Applies-to Doc. Type", "Applies-to Doc. Type"::Invoice);
        Validate(Rec."Document Type", "Document Type"::Payment);
        Validate(Rec."Account Type", "Account Type"::Customer);
        Validate(Rec."Bal. Account Type", "Bal. Account Type"::"Bank Account");

        GenJournalBatch.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
        GenJournalBatch.SetFilter(Name, '%1', Rec."Journal Batch Name");
        if GenJournalBatch.FindFirst() then
            Validate(rec."Bal. Account No.", GenJournalBatch."Bal. Account No.");

        "Payment DT" := System.CurrentDateTime;
        "Posting Date" := System.Today;
        Description := '';
    end;

    var
        TotalAmount: Decimal;
        LineNo: Integer;
        UserSetup: Record "User Setup";
        BankAccount: Record "Bank Account";
        GJline: Record "Gen. Journal Line";
        CLEntry: Record "Cust. Ledger Entry";
        GenJournalBatch: Record "Gen. Journal Batch";
        Customer: Record Customer;
        Text000: Label 'Today is %1';
}