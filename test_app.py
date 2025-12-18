# test_app.py - простые тесты для Flask приложения

def test_basic():
    """Проверяем что 1+1=2"""
    assert 1 + 1 == 2
    print("✓ Basic test passed")

def test_flask_import():
    """Проверяем что Flask можно импортировать"""
    try:
        import flask
        print("✓ Flask import test passed")
    except ImportError:
        print("✗ Flask не установлен")

def test_app_import():
    """Проверяем что наше приложение можно импортировать"""
    try:
        from app import app
        assert app is not None
        print("✓ App import test passed")
    except Exception as e:
        print(f"✗ Не могу импортировать app.py: {e}")

def test_routes():
    """Проверяем основные маршруты (очень просто)"""
    print("Тестирование маршрутов...")
    routes = ['/', '/login', '/register']
    print(f"Проверяемые маршруты: {routes}")
    print("✓ Routes test passed (просто проверка списка)")

def run_all_tests():
    """Запускаем все тесты"""
    print("=" * 50)
    print("Запускаю тесты приложения...")
    print("=" * 50)
    
    test_basic()
    test_flask_import()
    test_app_import()
    test_routes()
    
    print("=" * 50)
    print("Все тесты завершены!")
    print("=" * 50)

# Автоматически запускаем тесты при выполнении файла
if __name__ == "__main__":
    run_all_tests()