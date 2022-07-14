xmlport 50000 "Import sihterica"
{
    Caption = 'Uvoz satnica';
    Direction = Import;
    FieldDelimiter = 'None';
    FieldSeparator = ';';
    Format = VariableText;
    //ĐK
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(Employee; Employee)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'EmployeeAbsence';
                UseTemporary = false;
                textelement(EmpNo)
                {
                    MinOccurs = Zero;
                }
                textelement(Name)
                {
                    MinOccurs = Zero;
                }
                textelement(Dim)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode4)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode5)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode6)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode7)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode8)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode9)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode10)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode11)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode12)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode13)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode14)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode15)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode16)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode17)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode18)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode19)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode20)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode21)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode22)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode23)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode24)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode25)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode26)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode27)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode28)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode29)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode30)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode31)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode32)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode33)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode34)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode35)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode36)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode37)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode38)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode39)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode40)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode41)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode42)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode43)
                {
                    MinOccurs = Zero;
                }
                textelement(AbsCode44)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin
                    lineno += 1;

                    IF lineno = 6 THEN monthYCode := Name;

                    IF COPYSTR(EmpNo, 1, 1) <> 'E' THEN
                        currXMLport.SKIP;





                    BEGIN
                        FOR i := 4 TO 139 DO BEGIN

                            CASE i OF

                                4:
                                    IF (AbsCode4 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode4 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('1.') + monthYCode);
                                            SetLinepr(AbsCode4);
                                        END;
                                5:
                                    IF (AbsCode5 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF

(AbsCode5 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('2.') + monthYCode);
                                            SetLinepr(AbsCode5);
                                        END;
                                6:
                                    IF (AbsCode6 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode6 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('3.') + monthYCode);
                                            SetLinepr(AbsCode6);
                                        END;
                                7:
                                    IF (AbsCode7 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode7 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('4.') + monthYCode);
                                            SetLinepr(AbsCode7);
                                        END;
                                8:
                                    IF (AbsCode8 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode8 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('5.') + monthYCode);
                                            SetLinepr(AbsCode8);
                                        END;
                                9:
                                    IF (AbsCode9 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode9 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('6.') + monthYCode);
                                            SetLinepr(AbsCode9);
                                        END;
                                10:
                                    IF (AbsCode10 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode10 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('7.') + monthYCode);
                                            SetLinepr(AbsCode10);
                                        END;
                                11:
                                    IF (AbsCode11 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode11 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('8.') + monthYCode);
                                            SetLinepr(AbsCode11);
                                        END;
                                12:
                                    IF (AbsCode12 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode12 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('9.') + monthYCode);
                                            SetLinepr(AbsCode12);
                                        END;
                                13:
                                    IF (AbsCode13 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode13 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('10.') + monthYCode);
                                            SetLinepr(AbsCode13);
                                        END;
                                14:
                                    IF (AbsCode14 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode14 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('11.') + monthYCode);
                                            SetLinepr(AbsCode14);
                                        END;
                                15:
                                    IF (AbsCode15 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode15 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('12.') + monthYCode);
                                            SetLinepr(AbsCode15);
                                        END;
                                16:
                                    IF (AbsCode16 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode16 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('13.') + monthYCode);
                                            SetLinepr(AbsCode16);
                                        END;
                                17:
                                    IF (AbsCode17 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode17 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('14.') + monthYCode);
                                            SetLinepr(AbsCode17);
                                        END;
                                18:
                                    IF (AbsCode18 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode18 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('15.') + monthYCode);
                                            SetLinepr(AbsCode18);
                                        END;
                                19:
                                    IF (AbsCode19 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode19 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('16.') + monthYCode);
                                            SetLinepr(AbsCode19);
                                        END;
                                20:
                                    IF (AbsCode20 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode20 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('17.') + monthYCode);
                                            SetLinepr(AbsCode20);
                                        END;
                                21:
                                    IF (AbsCode21 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode21 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('18.') + monthYCode);
                                            SetLinepr(AbsCode21);
                                        END;
                                22:
                                    IF (AbsCode22 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode22 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('19.') + monthYCode);
                                            SetLinepr(AbsCode22);
                                        END;
                                23:
                                    IF (AbsCode23 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode23 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('20.') + monthYCode);
                                            SetLinepr(AbsCode23);
                                        END;
                                24:
                                    IF (AbsCode24 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode24 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('21.') + monthYCode);
                                            SetLinepr(AbsCode24);
                                        END;
                                25:
                                    IF (AbsCode25 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode25 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('22.') + monthYCode);
                                            SetLinepr(AbsCode25);
                                        END;
                                26:
                                    IF (AbsCode26 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode26 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('23.') + monthYCode);
                                            SetLinepr(AbsCode26);
                                        END;
                                27:
                                    IF (AbsCode27 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode27 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('24.') + monthYCode);
                                            SetLinepr(AbsCode27);
                                        END;
                                28:
                                    IF (AbsCode28 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode28 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('25.') + monthYCode);
                                            SetLinepr(AbsCode28);
                                        END;
                                29:
                                    IF (AbsCode29 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode29 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('26.') + monthYCode);
                                            SetLinepr(AbsCode29);
                                        END;
                                30:
                                    IF (AbsCode30 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode30 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('27.') + monthYCode);
                                            SetLinepr(AbsCode30);
                                        END;
                                31:
                                    IF (AbsCode31 = '') THEN
                                        ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                        IF
(AbsCode31 <> '-') THEN BEGIN
                                            EVALUATE(mydate, FORMAT('28.') + monthYCode);
                                            SetLinepr(AbsCode31);
                                        END;
                                32:
                                    IF COPYSTR(EmpNo, 1, 5) <> 'SIFRA' THEN BEGIN
                                        IF NOT (AbsCode32 = '') THEN BEGIN
                                            IF (AbsCode32 = '') THEN
                                                ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                                IF
(AbsCode32 <> '-') THEN BEGIN
                                                    EVALUATE(mydate, FORMAT('29.') + monthYCode);
                                                    SetLinepr(AbsCode32);
                                                END;
                                        END;
                                    END;

                                33:
                                    IF COPYSTR(EmpNo, 1, 5) <> 'SIFRA' THEN BEGIN
                                        IF NOT (AbsCode33 = '') THEN BEGIN
                                            IF (AbsCode33 = '') THEN
                                                ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                                IF
(AbsCode33 <> '-') THEN BEGIN
                                                    EVALUATE(mydate, FORMAT('30.') + monthYCode);
                                                    SetLinepr(AbsCode33);
                                                END;
                                        END;
                                    END;


                                /*IF (AbsCode33='') THEN ERROR ('Polje u šihtarici ne smije biti prazno!') ELSE IF
                                (AbsCode33<>'-') THEN BEGIN EVALUATE(mydate,FORMAT('30.')+monthYCode); SetLine(AbsCode33); END;*/
                                34:
                                    IF COPYSTR(EmpNo, 1, 5) <> 'SIFRA' THEN BEGIN
                                        IF NOT (AbsCode34 = '') THEN BEGIN
                                            IF (AbsCode34 = '') THEN
                                                ERROR('Polje u šihtarici ne smije biti prazno!') ELSE
                                                IF
(AbsCode34 <> '-') THEN BEGIN
                                                    EVALUATE(mydate, FORMAT('31.') + monthYCode);
                                                    SetLinepr(AbsCode34);
                                                END;
                                        END;
                                    END;
                                35:
                                    IF WS."Add. Columns" THEN BEGIN
                                        IF AbsCode35 <> '' THEN SetLinepr(AbsCode35) ELSE currXMLport.SKIP;
                                    END;
                                36:
                                    IF WS."Add. Columns" THEN BEGIN
                                        IF AbsCode36 <> '' THEN SetLinepr(AbsCode36) ELSE currXMLport.SKIP;
                                    END;
                                37:
                                    IF WS."Add. Columns" THEN BEGIN
                                        IF AbsCode37 <> '' THEN SetLinepr(AbsCode37) ELSE currXMLport.SKIP;
                                    END;

                            END;
                        END;
                    END;

                end;
            }
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

    trigger OnPostXmlPort()
    begin
        IF j <> 0 THEN
            MESSAGE('Import je završen!!!')
        //ELSE ERROR('Import je prekinut, provjerite da li importujete pravi file (*.csv)');
    end;

    trigger OnPreXmlPort()
    begin
        //HoursInDay:=8; //!!!!!!!!!!!!!!!!!!  ?????
        //WS.GET(WS."Overtime Code");
        k := 0;
    end;

    var
        EA: Record "Employee Absence";
        emp: Record Employee;
        Provjera: Boolean;
        SifraBr: Decimal;
        WS: Record "Wage Setup";
        mydate: Date;
        CA: Record "Cause of Absence";
        j: Integer;
        krm: Decimal;
        kp: Decimal;
        ExLine: Code[10];
        k: Decimal;
        month: Integer;
        year: Integer;
        HourPool: Decimal;
        AbsenceFill: Codeunit "Absence Fill";
        pomocni: Decimal;
        acc: Decimal;
        kol: Decimal;
        lineno: Integer;
        monthYCode: Text[30];
        i: Integer;
        Text000: Label 'Satnica za ovaj mjesec je već uvezena.';

    procedure SetLine(ac: Text[20])
    begin
        EA.INIT;
        EA."Employee No." := EmpNo;
        EA.VALIDATE("Employee No.");
        emp.SETFILTER("No.", EmpNo);
        emp.FIND('-');
        Provjera := EVALUATE(SifraBr, ac);
        IF ((Provjera) AND (WS.Overtime)) THEN BEGIN
            IF SifraBr > 8 THEN BEGIN
                EA.VALIDATE("Cause of Absence Code", WS."Overtime Code");
                EA.Quantity := SifraBr - emp."Hours In Day";
                EA."From Date" := mydate;
                EA."To Date" := mydate;
                EA.INSERT(TRUE);
                ac := FORMAT('8,7.5,6,4,2,1');
                CA.SETFILTER("Short Code", ac);
                CA.FIND('-');
                EA.VALIDATE("Cause of Absence Code", CA.Code);
            END
            ELSE BEGIN
                CA.SETFILTER("Short Code", ac);
                IF CA.FIND('-') THEN
                    EA.VALIDATE("Cause of Absence Code", CA.Code)
            END
        END
        ELSE
            IF (NOT (WS.Overtime) AND (Provjera)) THEN BEGIN
                ac := FORMAT('8,7.5,6,4,2,1');
                CA.SETFILTER("Short Code", ac);
                CA.FIND('-');
                EA.VALIDATE("Cause of Absence Code", CA.Code);
            END
            ELSE BEGIN
                CA.SETFILTER("Short Code", ac);
                IF CA.FIND('-') THEN
                    EA.VALIDATE("Cause of Absence Code", CA.Code)
                ELSE
                    ERROR('Kratka šifra' + ' ' + '"' + FORMAT(ac) + '"' + ' ' + 'ne postoji!');
            END;

        EA."From Date" := mydate;
        EA."To Date" := mydate;

        emp.SETFILTER("No.", EmpNo);
        IF emp.FIND('-') THEN
            EA.Quantity := emp."Hours In Day";   //!!!!!!!!!!! ?????

        EA.INSERT(TRUE);

        j := j + 1;


        emp.INIT;

        emp.SETFILTER("No.", EmpNo);
        IF emp.FIND('-') THEN BEGIN
            IF AbsCode35 <> '' THEN
                emp.VALIDATE("Department code", AbsCode35);
            IF AbsCode36 <> '' THEN BEGIN
                EVALUATE(krm, AbsCode36);

            END;
            IF AbsCode37 <> '' THEN BEGIN
                EVALUATE(kp, AbsCode37);

            END;
        END;

        emp.MODIFY(TRUE);
    end;

    procedure SetLine1(ac: Text[30])
    begin
        EA.INIT;
        EA."Employee No." := EmpNo;
        EA.VALIDATE("Employee No.");
        emp.SETFILTER("No.", EmpNo);
        emp.FIND('-');

        IF (ExLine <> emp."No.") THEN BEGIN
            k := 0;
            ExLine := EmpNo;
        END
        ELSE BEGIN
            k := k;
            ExLine := EmpNo;
        END;
        month := DATE2DMY(mydate, 2);
        year := DATE2DMY(mydate, 3);
        HourPool := AbsenceFill.GetHourPool(month, year, emp."Hours In Day");

        Provjera := EVALUATE(SifraBr, ac);
        IF ((Provjera) AND (WS.Overtime)) THEN BEGIN

            IF (HourPool >= k) THEN BEGIN
                IF NOT (CA."No Report") THEN
                    k := k + SifraBr;
                IF k > HourPool THEN BEGIN
                    pomocni := k - HourPool;
                    acc := SifraBr - pomocni;
                    IF acc <> 0 THEN BEGIN
                        ac := FORMAT('8,7.5,6,4,2,1');
                        CA.SETFILTER("Short Code", ac);
                        CA.FIND('-');
                        EA.VALIDATE("Cause of Absence Code", CA.Code);
                        EA.Quantity := acc;
                        EA."From Date" := mydate;
                        EA."To Date" := mydate;
                        EA.INSERT(TRUE);
                    END;
                    EA.VALIDATE("Cause of Absence Code", WS."Overtime Code");
                    EA.Quantity := pomocni;
                    EA."From Date" := mydate;
                    EA."To Date" := mydate;
                    EA.INSERT(TRUE);
                END
                ELSE BEGIN
                    ac := FORMAT('8,7.5,6,4,2,1');
                    CA.SETFILTER("Short Code", ac);
                    CA.FIND('-');
                    EA.VALIDATE("Cause of Absence Code", CA.Code);
                    EA.Quantity := SifraBr;
                    // EA.Quantity:=emp."Hours in Day";
                    EA."From Date" := mydate;
                    EA."To Date" := mydate;
                    j := j + 1;
                    EA.INSERT(TRUE);
                END
            END
            ELSE BEGIN
                //k:=k+SifraBr;
                EA.VALIDATE("Cause of Absence Code", WS."Overtime Code");
                EA.Quantity := SifraBr;
                // EA.Quantity:=emp."Hours in Day";
                EA."From Date" := mydate;
                EA."To Date" := mydate;
                EA.INSERT(TRUE);
            END
        END
        ELSE
            IF ((WS.Overtime) AND NOT (Provjera)) THEN BEGIN
                CA.SETFILTER("Short Code", ac);
                IF CA.FIND('-') THEN BEGIN
                    EA.VALIDATE("Cause of Absence Code", CA.Code);
                    EA.Quantity := emp."Hours In Day";
                    EA."From Date" := mydate;
                    EA."To Date" := mydate;
                    k := k + emp."Hours In Day";
                    j := j + 1;
                    //MESSAGE(emp."First Name");
                    EA.INSERT(TRUE);
                END
            END
            ELSE
                ERROR('Kratka šifra' + ' ' + '"' + FORMAT(ac) + '"' + ' ' + 'ne postoji!');

        j := j + 1;


        emp.INIT;

        emp.SETFILTER("No.", EmpNo);
        IF emp.FIND('-') THEN BEGIN
            IF AbsCode35 <> '' THEN
                emp.VALIDATE("Department code", AbsCode35);
            IF AbsCode36 <> '' THEN BEGIN
                EVALUATE(krm, AbsCode36);
                // emp."Position Coefficient":=krm
            END;
            IF AbsCode37 <> '' THEN BEGIN
                EVALUATE(kp, AbsCode37);
                //     emp."Productivity Coefficient":=kp
            END;
        END;

        emp.MODIFY(TRUE);
    end;

    procedure SetLine2(ac: Text[30])
    begin

        //bt01
        emp.INIT;
        emp.SETFILTER("No.", EmpNo);
        IF emp.FIND('-') THEN BEGIN
            IF AbsCode35 <> '' THEN
                emp.VALIDATE("Department code", AbsCode35);
            IF AbsCode36 <> '' THEN BEGIN
                EVALUATE(krm, AbsCode36);
                //   emp."Position Coefficient":=krm
            END;
            IF AbsCode37 <> '' THEN BEGIN
                EVALUATE(kp, AbsCode37);
                // emp."Productivity Coefficient":=kp
            END;
        END;
        emp.MODIFY(TRUE);
    end;

    procedure SetLinepr(ac: Text[20])
    begin
        EA.SETFILTER("Employee No.", '%1', EmpNo);
        EA.SETFILTER("From Date", '%1', mydate);
        IF NOT EA.FIND('-') THEN BEGIN
            EA.INIT;

            EA."Employee No." := EmpNo;
            EA.VALIDATE("Employee No.");
            EA.VALIDATE("Unit of Measure Code", 'HOUR');
            IF (ac <> 'GO') AND (ac <> 'DR-PRAZNIK') AND (ac <> 'BOL') AND (ac <> 'SL-PUT') AND (ac <> 'SL-PUT-4') AND (ac <> 'BOL-42') AND (ac <> 'DR-PRAZNIK')
            AND (ac <> 'NPL-O') AND (ac <> 'PL-O') THEN BEGIN

                EA."From Date" := mydate;
                EA."To Date" := mydate;
                IF ac IN ['0', '0,5', '1', '1,5', '2', '2,5', '3', '3,5', '4', '4,5',
                          '5', '5,5', '6', '6,5', '7', '7,5', '8', 'REDOVNO'] THEN BEGIN
                    CA.SETFILTER("Short Code", '8');
                    CA.FIND('-');
                    EA.VALIDATE("Cause of Absence Code", CA.Code);

                    //IF EVALUATE(kol,ac) THEN
                    EA.VALIDATE(Quantity, 8);
                    EA."Global Dimension 2 Code" := Dim;
                    IF ac <> '0' THEN
                        EA.INSERT(TRUE);

                    j := j + 1;

                END;
            END;


            IF (ac = 'GO') OR (ac = 'DR-PRAZ') OR (ac = 'BOL') OR (ac = 'BOL-80') OR (ac = 'BOL-100') OR (ac = 'SL-PUT') OR (ac = 'SL-PUT-4') OR (ac = 'BOL-42') OR (ac = 'DR-PRAZNIK') OR (ac = 'PL-O')
            OR (ac = 'NPL-O') THEN BEGIN

                EA."From Date" := mydate;
                EA."To Date" := mydate;

                IF (ac = 'GO') THEN
                    EA.VALIDATE("Cause of Absence Code", 'GOD-ODMOR');

                IF (ac = 'DR-PRAZ') THEN
                    EA.VALIDATE("Cause of Absence Code", 'DR-PRAZNIK');

                IF (ac = 'BOL') THEN
                    EA.VALIDATE("Cause of Absence Code", 'BOL');

                IF (ac = 'BOL-42') THEN
                    EA.VALIDATE("Cause of Absence Code", 'BOL-42');

                IF (ac = 'SL-PUT') THEN
                    EA.VALIDATE("Cause of Absence Code", 'SL-PUT');

                IF (ac = 'SL-PUT-4') THEN
                    EA.VALIDATE("Cause of Absence Code", 'SL-PUT-4');
                IF (ac = 'DR-PRAZNIK') THEN
                    EA.VALIDATE("Cause of Absence Code", 'DR-PRAZNIK');
                IF (ac = 'NPL-O') THEN
                    EA.VALIDATE("Cause of Absence Code", 'NPL-O');
                IF (ac = 'PL-O') THEN
                    EA.VALIDATE("Cause of Absence Code", 'PL-O');

                IF (ac = 'BOL-100') THEN
                    EA.VALIDATE("Cause of Absence Code", 'BOL-100');

                IF (ac = 'BOL-80') THEN
                    EA.VALIDATE("Cause of Absence Code", 'BOL-80');

                //bt01
                emp.SETFILTER("No.", EmpNo);
                IF emp.FIND('-') THEN
                    IF emp."Hours In Day" = 8 THEN
                        EA.VALIDATE(Quantity, 8)
                    ELSE
                        EA.VALIDATE(Quantity, 4);



                EA."Global Dimension 2 Code" := Dim;
                //IF ac<> '0' THEN
                EA.INSERT(TRUE);

                j := j + 1;
            END;
        END
    end;
}

