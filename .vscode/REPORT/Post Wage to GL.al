report 50027 "Post Wage to GL"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("<Wage Ledger Entry>"; "Wage Ledger Entry")
        {

            trigger OnAfterGetRecord()
            begin
                //SETFILTER("Wage Calculation Type",'<>%1','');
                WageSetupGET.get();
                IF ("Wage Calculation Type" = 0) THEN BEGIN
                    TemplateName := WageSetupGET."Wage Journal Template";
                    BatchName := WageSetupGET."Wage Batch Name";
                END;

                IF "Wage Calculation Type" = 0 THEN BEGIN
                    TemplateName := WageSetupGET."Wage Journal Template";
                    BatchName := WageSetupGET."Wage Batch Name";
                END;


                IF (("Wage Calculation Type" = 1)) THEN BEGIN
                    TemplateName := WageSetupGET."Wage Journal Template";
                    BatchName := WageSetupGET."Wage Batch Name";
                END;

                IF "Wage Calculation Type" = 2 THEN BEGIN
                    TemplateName := WageSetupGET."Wage Journal Template";
                    BatchName := WageSetupGET."Wage Batch Name";
                END;

                IF "Wage Calculation Type" = 3 THEN BEGIN
                    TemplateName := WageSetupGET."Wage Journal Template";
                    BatchName := WageSetupGET."Wage Batch Name";
                END;

                GenJnlTemplate.GET(TemplateName);
                GenJnlBatch.GET(TemplateName, BatchName);
                GenJnlLine.SETRANGE("Journal Template Name", GenJnlBatch."Journal Template Name");
                IF GenJnlBatch.Name <> '' THEN
                    GenJnlLine.SETRANGE("Journal Batch Name", GenJnlBatch.Name)
                ELSE
                    GenJnlLine.SETRANGE("Journal Batch Name", '');
                IF GenJnlLine.FIND('+') THEN;

                IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                    CLEAR(NoSeriesMgt);
                    DocNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", "Posting Date");
                END;







                C1 += 1;
                //NKWindow.UPDATE(1,ROUND(C1 / TotalRecNo1 * 10000,1));

                IF FirstRow THEN BEGIN
                    FirstRow := FALSE;
                    WageHeader.GET("Document No.");

                    PostDate := "Posting Date";
                END;
            end;

            trigger OnPostDataItem()
            begin
                RoundItems;
            end;

            trigger OnPreDataItem()
            begin
                LastNo := 0;



                GenJnlLine.LOCKTABLE;

                TotalRecNo1 := COUNTAPPROX;
                C1 := 0;

                WJB.RESET;
                //BT
                WJB.DELETEALL;
                NextWBNo := 0;

                FirstRow := TRUE;
            end;
        }
        dataitem("<Wage Value Entry>"; "Wage Value Entry")
        {
            RequestFilterFields = "Document No.", "Wage Calculation Type", "Employee No.";

            trigger OnAfterGetRecord()
            begin


                PostSetup.GET("Wage Posting Group");

                CASE "Entry Type" OF
                    "Entry Type"::Contribution:
                        BEGIN
                            AddTaxPostSetup.GET("Contribution Type", "Wage Posting Group");
                            AddTaxPostSetup.TESTFIELD(Account);
                            AddTaxPostSetup.TESTFIELD("Bal. Account");
                            // AddTaxPostSetup.TESTFIELD("Transit Account");
                            IF (("Use Apportionment Account" = TRUE) AND ("Wage Addition Type" <> '') AND (Round <> 2)) THEN BEGIN
                                WAT.SETFILTER(Code, '%1', "Wage Addition Type");
                                IF WAT.FINDFIRST THEN BEGIN
                                    Account := WAT."Apportionment Account";
                                END;
                            END
                            ELSE BEGIN
                                Account := AddTaxPostSetup.Account;
                            END;
                            BalAccount := AddTaxPostSetup."Bal. Account";
                            Transit := AddTaxPostSetup."Transit Account";
                        END;

                    "Entry Type"::Tax:
                        BEGIN
                            PostSetup.TESTFIELD("Tax Account");
                            PostSetup.TESTFIELD("Tax Bal. Account");
                            //PostSetup.TESTFIELD("Tax Transit Account");
                            IF (("Use Apportionment Account" = TRUE) AND ("Wage Addition Type" <> '') AND (Round <> 2)) THEN BEGIN
                                WAT.SETFILTER(Code, '%1', "Wage Addition Type");
                                IF WAT.FINDFIRST THEN BEGIN
                                    Account := WAT."Apportionment Account";
                                END;
                            END
                            ELSE BEGIN
                                Account := PostSetup."Tax Account";
                            END;
                            BalAccount := PostSetup."Tax Bal. Account";
                            Transit := PostSetup."Tax Transit Account";
                        END;
                    "Entry Type"::"Added Tax Per City":
                        BEGIN
                            PostSetup.TESTFIELD("City Tax Account");
                            PostSetup.TESTFIELD("City Tax Bal. Account");

                            Account := PostSetup."City Tax Account";
                            BalAccount := PostSetup."City Tax Bal. Account";

                        END;

                    "Entry Type"::"Net Wage":
                        BEGIN
                            PostSetup.TESTFIELD("Netto Account");
                            PostSetup.TESTFIELD("Netto Bal. Account");
                            // PostSetup.TESTFIELD("Netto Transit Account");
                            IF (("Use Apportionment Account" = TRUE) AND ("Wage Addition Type" <> '') AND (Round <> 2)) THEN BEGIN
                                WAT.SETFILTER(Code, '%1', "Wage Addition Type");
                                IF WAT.FINDFIRST THEN BEGIN
                                    Account := WAT."Apportionment Account";
                                END;
                            END
                            ELSE BEGIN
                                Account := PostSetup."Netto Account";
                            END;
                            BalAccount := PostSetup."Netto Bal. Account";
                            Transit := PostSetup."Netto Transit Account";
                        END;
                    "Entry Type"::Use:
                        BEGIN
                            PostSetup.TESTFIELD("Use Account");
                            PostSetup.TESTFIELD("Use Bal. Account");
                            //PostSetup.TESTFIELD("Use Transit Account");

                            Account := PostSetup."Use Account";
                            BalAccount := PostSetup."Use Bal. Account";
                            Transit := PostSetup."Use Transit Account";
                        END;
                    "Entry Type"::"Sick Leave-Company":
                        BEGIN
                            // PostSetup.TESTFIELD("Sick Fund Account");
                            //PostSetup.TESTFIELD("Sick Fund Bal. Account");

                            //   Account:='';
                            // BalAccount:='';
                        END;
                    "Entry Type"::Reduction:
                        BEGIN
                            IF ("Reduction No.") <> '' THEN BEGIN
                                Red.GET("Reduction Type");
                                Red.CalcFields("Bal. G/L Account", "G/L Account");
                                Red.TESTFIELD("Bal. G/L Account");
                                Red.TESTFIELD("G/L Account");
                                // Red.TESTFIELD("Transit  Account");
                                // Red.TESTFIELD("Transit  Account 2");
                                Account := Red."G/L Account";
                                BalAccount := Red."Bal. G/L Account";
                                Transit := Red."Transit  Account";
                                Transit2 := Red."Transit  Account 2";

                            END;
                        END;
                    "Entry Type"::"Meal to pay":
                        BEGIN
                            PostSetup.TESTFIELD("Meal Account to pay");
                            PostSetup.TESTFIELD("Meal Bal. Account to pay");
                            // PostSetup.TESTFIELD("Meal Transit Account");

                            Account := PostSetup."Meal Account to pay";
                            BalAccount := PostSetup."Meal Bal. Account to pay";
                            // Transit:=PostSetup."Meal Transit Account"
                            //Org:= "Global Dimension 1 Code";
                            //Emp:= "Employee No.";
                        END;
                    "Entry Type"::Transport:
                        BEGIN
                            PostSetup.TESTFIELD("Transport Account");
                            PostSetup.TESTFIELD("Transport Bal. Account");
                            //PostSetup.TESTFIELD("Transport Transit Account");

                            Account := PostSetup."Transport Account";
                            BalAccount := PostSetup."Transport Bal. Account";
                            Transit := PostSetup."Transport Transit Account"
                        END;

                    "Entry Type"::Untaxable:
                        BEGIN
                            WageAdditionType.GET("Wage Addition Type");
                            WageAdditionType.TESTFIELD("G/L Account No.");
                            WageAdditionType.TESTFIELD("G/L Balance Account No.");
                            IF "Use Apportionment Account" THEN
                                Account := WageAdditionType."Apportionment Account"
                            ELSE
                                Account := WageAdditionType."G/L Account No.";
                            BalAccount := WageAdditionType."G/L Balance Account No.";
                            Transit := WageAdditionType."Transit Account No.";
                        END;

                    "Entry Type"::Taxable:

                        BEGIN

                            WageAdditionType.GET("Wage Addition Type");
                            WageAdditionType.TESTFIELD("G/L Account No.");
                            WageAdditionType.TESTFIELD("G/L Balance Account No.");
                            IF "Use Apportionment Account" THEN
                                Account := WageAdditionType."Apportionment Account"
                            ELSE
                                Account := WageAdditionType."G/L Account No.";
                            BalAccount := WageAdditionType."G/L Balance Account No.";
                            Transit := WageAdditionType."Transit Account No.";

                        END;



                END;

                GLAcc.GET(Account);
                GLAcc.CheckGLAcc();
                GLAcc.GET(BalAccount);
                GLAcc.CheckGLAcc();

                DimCode := "Global Dimension 1 Code";
                External := "Global Dimension 1 Code";
                InsertLine := FALSE;
                IsClass3 := FALSE;
                WageSetupGET.Get();

                GenJnlLine.RESET;
                IF "Wage Calculation Type" = 0 THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF ("Wage Calculation Type" = 1) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF ("Wage Calculation Type" = 2) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF ("Wage Calculation Type" = 3) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;



                GenJnlLine.SETFILTER("Account No.", Account);
                GenJnlLine.SETFILTER("Credit Amount", '%1', 0);
                IF COPYSTR(Account, 1, 1) = '6' THEN BEGIN
                    IsClass3 := TRUE;
                    //NKwg
                    GenJnlLine.SETFILTER("Shortcut Dimension 1 Code", External);
                    //GenJnlLine.SETFILTER("External Document No.",External);
                    //NKWG
                END;

                IF ((GenJnlLine.FINDFIRST) AND ("Entry Type" <> "Entry Type"::Use)) THEN BEGIN
                    AppendAmount := GenJnlLine."Debit Amount" + "Cost Amount (Actual)";

                    GenJnlLine.VALIDATE("Debit Amount", AppendAmount);

                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", External);

                    GenJnlLine.MODIFY;

                    WJB.RESET;
                    WJB.SETFILTER("Account No.", '%1|%2', Account, BalAccount);
                    WJB.SETFILTER("Credit Amount", '%1', 0);
                    IF IsClass3 THEN WJB.SETRANGE("Global Dimension 1 Code", External);
                    IF WJB.FINDFIRST THEN
                        WJB."Debit Amount" += "Cost Amount (Actual)";
                    WJB.MODIFY;

                END
                ELSE BEGIN
                    GenJnlLine.RESET;
                    GenJnlLine.INIT;
                    WageSetupGET.Get();
                    IF "Wage Posting Group" = 'FBIH' THEN BEGIN
                        GenJnlLine.VALIDATE("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.VALIDATE("Journal Batch Name", WageSetupGET."Wage Batch Name");


                    END;

                    IF (("Wage Calculation Type" = 1)) THEN BEGIN
                        GenJnlLine.VALIDATE("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.VALIDATE("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    END;

                    IF ("Wage Calculation Type" = 2) THEN BEGIN
                        GenJnlLine.VALIDATE("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.VALIDATE("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    END;

                    IF ("Wage Calculation Type" = 3) THEN BEGIN
                        GenJnlLine.VALIDATE("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.VALIDATE("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    END;

                    GenJnlLine.VALIDATE("Source Code", GenJnlTemplate."Source Code");
                    GenJnlLine.VALIDATE("Reason Code", GenJnlBatch."Reason Code");
                    LastNo += 10000;
                    GenJnlLine."Line No." := LastNo;
                    GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::" ");
                    GenJnlLine.VALIDATE("Debit Amount", "Cost Amount (Actual)");
                    IF (("Wage Calculation Type" = 4) AND (Round <> 2)) THEN
                        GenJnlLine."Document No." := 'DODACI ' + FORMAT("Posting Date")
                    ELSE
                        IF (("Wage Calculation Type" = 0) OR (("Wage Calculation Type" = 4) AND (Round = 2))) THEN
                            GenJnlLine."Document No." := 'PLATE ' + FORMAT("Posting Date")
                        ELSE
                            GenJnlLine."Document No." := 'UOD ' + FORMAT("Posting Date");
                    //NK

                    GenJnlLine.VALIDATE("Posting Date", "Posting Date");
                    GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                    GenJnlLine.VALIDATE("Account No.", Account);
                    GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account");
                    GenJnlLine.VALIDATE("Bal. Account No.", BalAccount);

                    GenJnlLine.VALIDATE("Gen. Bus. Posting Group", ' ');
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", External);
                    // MESSAGE (GenJnlLine."Shortcut Dimension 2 Code"+'  '+External);
                    GenJnlLine.INSERT;

                    WJB.RESET;
                    WJB.INIT;
                    NextWBNo += 1;
                    WJB."Entry No." := NextWBNo;
                    WJB."Account No." := Account;
                    WJB."Credit Amount" := 0;
                    WJB."Debit Amount" := "Cost Amount (Actual)";
                    WJB."Document  No." := FORMAT("Entry Type");
                    //NK IF IsClass3 THEN WJB."Global Dimension 1 Code" := DimCode;
                    IF IsClass3 THEN WJB."Global Dimension 1 Code" := External;
                    WJB.INSERT;
                END;

                "Cost Posted to G/L" := "Cost Amount (Actual)";
                "G/L Account No." := Account;
                MODIFY;
                InsertLine := FALSE;
                IsClass3 := FALSE;

                GenJnlLine.RESET;
                WageSetupGET.Get();

                IF ("Wage Calculation Type" = 0) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF (("Wage Calculation Type" = 1)) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF ("Wage Calculation Type" = 2) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF ("Wage Calculation Type" = 3) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;


                GenJnlLine.SETFILTER("Account No.", '%1', BalAccount);
                GenJnlLine.SETFILTER("Debit Amount", '%1', 0);

                //IF  ((COPYSTR(Account, 1, 1) = '6') OR (COPYSTR(Account, 1, 1) = '5') OR (COPYSTR(Account, 1, 1) = '9'))   THEN BEGIN
                IF (COPYSTR(Account, 1, 1) = '6') THEN BEGIN
                    IsClass3 := TRUE;
                    GenJnlLine.SETFILTER("Shortcut Dimension 1 Code", External);
                END;


                IF ((GenJnlLine.FINDFIRST) AND ("Entry Type" <> "Entry Type"::Use)) THEN BEGIN
                    AppendAmount := GenJnlLine."Credit Amount" + "Cost Amount (Actual)";
                    GenJnlLine.VALIDATE("Credit Amount", AppendAmount);
                    GenJnlLine.MODIFY;

                    /*nk2
                     WJB.RESET;
                     WJB.SETRANGE("Account No.",Transit);
                    // WJB.SETFILTER("Debit Amount",'%1',0);
                    //NK IF IsClass3 THEN WJB.SETRANGE("Global Dimension 1 Code",DimCode);
                    IF IsClass3 THEN WJB.SETRANGE("Global Dimension 1 Code", External);
                     IF WJB.FINDFIRST THEN
                     WJB."Credit Amount" += "Cost Amount (Actual)";
                     WJB.MODIFY;*/

                END;
                /*ELSE BEGIN
                 GenJnlLine.RESET;
                 GenJnlLine.INIT;
                // GenJnlLine.VALIDATE("Journal Template Name",TemplateName);
                // GenJnlLine.VALIDATE("Journal Batch Name",BatchName);
                
                IF ("Wage Calculation Type"=0)   THEN BEGIN
                GenJnlLine.VALIDATE("Journal Template Name",'OPŠTE');
                GenJnlLine.VALIDATE("Journal Batch Name",'OPŠTE');
                
                END;
                
                IF (("Wage Calculation Type"=1))  THEN BEGIN
                GenJnlLine.VALIDATE("Journal Template Name",'OPŠTE');
                GenJnlLine.VALIDATE("Journal Batch Name",'OPŠTE');
                END;
                
                IF ("Wage Calculation Type"=2)   THEN BEGIN
                GenJnlLine.VALIDATE("Journal Template Name",'OPŠTE');
                GenJnlLine.VALIDATE("Journal Batch Name",'OPŠTE');
                END;
                
                IF ("Wage Calculation Type"=3)   THEN BEGIN
                GenJnlLine.VALIDATE("Journal Template Name",'OPŠTE');
                GenJnlLine.VALIDATE("Journal Batch Name",'OPŠTE');
                
                END;
                
                 GenJnlLine.VALIDATE("Source Code",GenJnlTemplate."Source Code");
                 GenJnlLine.VALIDATE("Reason Code",GenJnlBatch."Reason Code");
                 LastNo += 10000;
                 GenJnlLine."Line No." := LastNo;
                 GenJnlLine.VALIDATE("Document Type",GenJnlLine."Document Type"::" ");
                 GenJnlLine.VALIDATE("Credit Amount","Cost Amount (Actual)");
                
                 //NK
                 GenJnlLine."Shortcut Dimension 1 Code":=External;
                 GenJnlLine.VALIDATE("Gen. Bus. Posting Group",' ');
                  IF (("Wage Calculation Type"=4) AND (Round <>2))  THEN
                  GenJnlLine."Document No.":='DODACI '+FORMAT("Posting Date")
                  ELSE IF (("Wage Calculation Type"=0) OR (("Wage Calculation Type"=4) AND (Round =2))) THEN
                 GenJnlLine."Document No.":='PLATE '+FORMAT("Posting Date")
                 ELSE
                 GenJnlLine."Document No.":='UOD '+FORMAT("Posting Date");
                 GenJnlLine.VALIDATE("Posting Date","Posting Date");
                 GenJnlLine.VALIDATE("Account Type",GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.",Transit);
                
                 GenJnlLine.VALIDATE("Bal. Account Type",GenJnlLine."Bal. Account Type"::"G/L Account");
                
                 GenJnlLine.VALIDATE("Bal. Account No.",Transit);
                 GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",WJB."Global Dimension 1 Code");
                 GenJnlLine.INSERT;*/



                WJB.RESET;
                WJB.INIT;
                NextWBNo += 1;
                WJB."Entry No." := NextWBNo;
                WJB."Account No." := BalAccount;
                WJB."Debit Amount" := 0;
                WJB."Credit Amount" := "Cost Amount (Actual)";
                IF IsClass3 THEN WJB."Global Dimension 1 Code" := DimCode;
                IF IsClass3 THEN WJB."Global Dimension 1 Code" := External;
                WJB.INSERT;


                /*ec IF IsClass3 THEN BEGIN
                  GenDim.INIT;
                  GenDim.VALIDATE("Table ID", DATABASE::"Gen. Journal Line");
                  GenDim.VALIDATE("Journal Template Name", GenJnlLine."Journal Template Name");
                  GenDim.VALIDATE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                  GenDim.VALIDATE("Journal Line No.", GenJnlLine."Line No.");
                  GenDim."Dimension Code":='PROJECT';
                  GenDim."Dimension Value Code":=DimCode;
                  GenDim.INSERT(TRUE);
                
                  {
                  DefDim.RESET;
                  DefDim.SETRANGE("Table ID",DATABASE::Employee);
                  DefDim.SETRANGE("No.","Wage Ledger Entry"."Employee No.");
                  IF DefDim.FINDFIRST THEN
                   REPEAT
                    GenDim.INIT;
                    GenDim.VALIDATE("Table ID", DATABASE::"Gen. Journal Line");
                    GenDim.VALIDATE("Journal Template Name", GenJnlLine."Journal Template Name");
                    GenDim.VALIDATE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                    GenDim.VALIDATE("Journal Line No.", GenJnlLine."Line No.");
                    GenDim."Dimension Code":=DefDim."Dimension Code";
                    GenDim."Dimension Value Code":=DefDim."Dimension Value Code";
                    GenDim.INSERT(TRUE);
                   UNTIL DefDim.NEXT=0;
                   }
                 END;
                END;
                
                "Cost Posted to G/L":="Cost Amount (Actual)";
                "G/L Bal. Account No." := BalAccount;
                MODIFY;*/

                /*IF "Entry Type"="Entry Type"::Reduction THEN BEGIN
                
                GenJnlLine.SETFILTER("Account No.",'%1',Transit2);
                GenJnlLine.SETFILTER("Debit Amount",'%1',0);
                
                IF GenJnlLine.FINDFIRST THEN BEGIN
                 AppendAmount := GenJnlLine."Credit Amount" + "Cost Amount (Actual)";
                 GenJnlLine.VALIDATE("Credit Amount",AppendAmount);
                 GenJnlLine.MODIFY;
                
                
                 WJB.RESET;
                 WJB.SETRANGE("Account No.",Transit2);
                IF IsClass3 THEN WJB.SETRANGE("Global Dimension 1 Code", External);
                 IF WJB.FINDFIRST THEN
                 WJB."Credit Amount" += "Cost Amount (Actual)";
                 WJB.MODIFY;
                
                END
                ELSE BEGIN
                 GenJnlLine.RESET;
                 GenJnlLine.INIT;
                
                
                 IF ("Wage Calculation Type"=0)   THEN BEGIN
                GenJnlLine.VALIDATE("Journal Template Name",'OPŠTE');
                GenJnlLine.VALIDATE("Journal Batch Name",'OPŠTE');
                
                END;
                 GenJnlLine.VALIDATE("Source Code",GenJnlTemplate."Source Code");
                 GenJnlLine.VALIDATE("Reason Code",GenJnlBatch."Reason Code");
                 LastNo += 10000;
                 GenJnlLine."Line No." := LastNo;
                 GenJnlLine.VALIDATE("Document Type",GenJnlLine."Document Type"::" ");
                 GenJnlLine.VALIDATE("Credit Amount","Cost Amount (Actual)");
                
                 //NK
                 GenJnlLine."Shortcut Dimension 1 Code":=External;
                 GenJnlLine.VALIDATE("Gen. Bus. Posting Group",' ');
                  IF (("Wage Calculation Type"=4) AND (Round <>2))  THEN
                  GenJnlLine."Document No.":='DODACI '+FORMAT("Posting Date")
                  ELSE IF (("Wage Calculation Type"=0) OR (("Wage Calculation Type"=4) AND (Round =2))) THEN
                 GenJnlLine."Document No.":='PLATE '+FORMAT("Posting Date")
                 ELSE
                 GenJnlLine."Document No.":='UOD '+FORMAT("Posting Date");
                 GenJnlLine.VALIDATE("Posting Date","Posting Date");
                 GenJnlLine.VALIDATE("Account Type",GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.",Transit2);
                
                 GenJnlLine.VALIDATE("Bal. Account Type",GenJnlLine."Bal. Account Type"::"G/L Account");
                
                 GenJnlLine.VALIDATE("Bal. Account No.",Transit2);
                 GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",WJB."Global Dimension 1 Code");
                 GenJnlLine.INSERT;
                
                END;
                
                 WJB.RESET;
                 WJB.INIT;
                 NextWBNo += 1;
                 WJB."Entry No." := NextWBNo;
                 WJB."Account No." := Transit2;
                 WJB."Debit Amount" := 0;
                 WJB."Credit Amount" := "Cost Amount (Actual)";
                 IF IsClass3 THEN WJB."Global Dimension 1 Code" := DimCode;
                 IF IsClass3 THEN WJB."Global Dimension 1 Code" := External;
                 WJB.INSERT;
                
                "Cost Posted to G/L":="Cost Amount (Actual)";
                "G/L Account No." := Transit2;
                MODIFY;
                InsertLine := FALSE;
                IsClass3 := FALSE;
                
                GenJnlLine.RESET;*/

                // END;


            end;

            trigger OnPreDataItem()
            begin
                FINDLAST;
                SETFILTER("Document No.", '%1', "Document No.");
                SETFILTER("Wage Addition Type", '<>%1', 'KOREKCIJA');
                SETFILTER("Entry Type", '<>%1', "Entry Type"::Taxable);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin

        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end
    end;

    trigger OnPostReport()
    begin

        MESSAGE(Txt001);
        GenJournalPage.RUN;
    end;

    trigger OnPreReport()
    begin
        WageSetupGET.Get();
        GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
        GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
        //GenJnlLine.SETFILTER("Document No.",DocNo);
        IF GenJnlLine.FINDSET THEN GenJnlLine.DELETEALL;
    end;

    var
        WAT: Record "Wage Addition Type";

        WageSetupGET: Record "Wage Setup";
        GenJournalPage: Page "General Journal";
        PostSetup: Record "Wage Posting Groups";
        AddTaxPostSetup: Record "Contribution Posting Setup";
        GLAcc: Record "G/L Account";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlTemplate: Record "Gen. Journal Template";
        WageAdditionType: Record "Wage Addition Type";
        WageHeader: Record "Wage Header";
        WageSetup: Record "Wage Setup";
        TemplateName: Code[10];
        BatchName: Code[10];
        Account: Code[10];
        BalAccount: Code[10];
        Transit: Code[10];
        Dimen: Record "Dimension";
        DefDim: Record "Default Dimension";
        Employee: Record Employee;
        Red: Record "Reduction Types";
        Org: Code[10];
        AccountNo: Code[10];
        BalanceAccountNo: Code[10];
        GenJnlLineForPosting: Record "Gen. Journal Line";
        External: Code[30];
        Emp: Code[10];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DocNo: Code[20];
        DimCode: Code[20];
        InsertLine: Boolean;
        IsClass3: Boolean;
        Window: Dialog;
        TotalRecNo1: Integer;
        TotalRecNo2: Integer;
        C1: Integer;
        C2: Integer;
        AppendAmount: Decimal;
        LastNo: Integer;
        WJB: Record "Wage Jnl. Buffer";
        NextWBNo: Integer;
        FirstRow: Boolean;
        PostDate: Date;
        Txt001: Label 'Wage Calculation has been transfered to General journal -Wages.';
        Wve: Record "Wage Value Entry";
        Transit2: Code[10];
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';

    procedure RoundItems()
    begin
        WJB.RESET;

        IF WJB.FINDFIRST THEN
            REPEAT
                GenJnlLine.RESET;
                GenJnlLine.SETFILTER("Journal Template Name", TemplateName);
                GenJnlLine.SETFILTER("Journal Batch Name", BatchName);
                GenJnlLine.SETFILTER("Document No.", DocNo);

                GenJnlLine.SETFILTER("Account No.", WJB."Account No.");
                IF WJB."Debit Amount" = 0 THEN
                    GenJnlLine.SETFILTER("Debit Amount", '%1', 0)
                ELSE
                    GenJnlLine.SETFILTER("Credit Amount", '%1', 0);

                IF WJB."Global Dimension 1 Code" <> '' THEN
                    GenJnlLine.SETRANGE("Shortcut Dimension 1 Code", WJB."Global Dimension 1 Code");

                GenJnlLine.FINDFIRST;
                IF WJB."Debit Amount" <> 0 THEN
                    GenJnlLine.VALIDATE("Debit Amount", WJB."Debit Amount");
                // ELSE
                GenJnlLine.VALIDATE("Credit Amount", WJB."Credit Amount");

                GenJnlLine."Document No." := 'PLATE ';
                GenJnlLine.MODIFY;
            UNTIL WJB.NEXT = 0;
    end;
}

