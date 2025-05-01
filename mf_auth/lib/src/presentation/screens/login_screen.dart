import 'package:another_flushbar/flushbar_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_auth/src/constants/app_theme.dart';
import 'package:mf_auth/src/presentation/store/auth_store.dart';
import 'package:mf_auth/src/presentation/store/form_store.dart';
import 'package:mf_auth/src/presentation/widgets/empty_app_bar_widget.dart';
import 'package:mf_auth/src/presentation/widgets/rounded_button_widget.dart';
import 'package:mf_auth/src/presentation/widgets/textfield_widget.dart';
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:shared_dependencies/src/localization/app_localization.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers:-----------------------------------------------------------
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late final FormStore _formStore;
  late final AuthStore _authStore;

  //focus node:-----------------------------------------------------------------
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _formStore = GetIt.instance<FormStore>();
    _authStore = GetIt.instance<AuthStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: const EmptyAppBar(),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _buildLoginForm(),
        Observer(
          builder: (context) {
            if (_authStore.success) {
              // Mover la navegación fuera del build para evitar problemas
              WidgetsBinding.instance.addPostFrameCallback((_) {
                GoRouter.of(context).go('/posts');
              });
            } else if (_authStore.errorMessage.isNotEmpty) {
              _showErrorMessage(_authStore.errorMessage);
            }
            return const SizedBox.shrink();
          },
        ),
        Observer(
          builder: (context) => _authStore.isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink(),
        )
      ],
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 100.0),
            const Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 24.0),
            _buildUserIdField(),
            _buildPasswordField(),
            _buildForgotPasswordButton(),
            _buildSignInButton()
          ],
        ),
      ),
    );
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('login_email_hint'),
          inputType: TextInputType.emailAddress,
          icon: Icons.person,
          iconColor: Colors.black54,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: _formStore.setUserId,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.userEmailError,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('login_password_hint'),
          isObscure: true,
          padding: const EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: Colors.black54,
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          errorText: _formStore.passwordError,
          onChanged: _formStore.setPassword,
        );
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          AppLocalizations.of(context).translate('login_forgot_password'),
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.orangeAccent),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildSignInButton() {
    return RoundedButtonWidget(
      buttonText: AppLocalizations.of(context).translate('login_btn_sign_in'),
      buttonColor: AuthThemeData.primaryButtonColor,
      textColor: Colors.white,
      onPressed: _handleLogin,
    );
  }

  void _handleLogin() {
    _formStore.trySubmit();
    if (_formStore.canLogin) {
      FocusScope.of(context).unfocus();
      _authStore.login(_userEmailController.text, _passwordController.text);
    } else {
      _showErrorMessage(AppLocalizations.of(context).translate('login_error_fill_fields'));
    }
  }

  // General Methods:-----------------------------------------------------------
  Widget _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      // Usar addPostFrameCallback para mostrar el mensaje después de que se complete el frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: 'Error',
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      });
    }

    return const SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
} 